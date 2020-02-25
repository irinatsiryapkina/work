"""
Generate views for each module and for all modules.
"""

import itertools
import string

from database import Database

regions = ('CA', 'ROTUS', 'National')
modules = ('CAFO', 'LF', 'WWTP')

# generate schema names
schemas = ['{0} {1}'.format(*x) for x in itertools.product(regions, modules)]

# set reused sql pieces
sql_create = """CREATE OR REPLACE VIEW "{schema}"."{view}" AS\nSELECT "ids"."id"\n     , """
sql_close = '\nORDER BY "ids"."id";\n'


if __name__ == '__main__':
    with Database(db_host='walter.nrel.gov', db_name='wte') as db:
        # init table list
        model_join_tables = []

        # init column list
        model_select_columns = []

        # init global record ID set
        model_record_ids = set()

        # model wide table alias
        model_alias_index = 0

        # get all columns in all tables in all schemas
        for s_i, schema in enumerate(schemas):
            # init schema record id set
            schema_record_ids = set()

            # init schema table list
            schema_join_tables = []

            # init schema column list
            schema_select_columns = []

            # get tables
            tables = [x[0] for x in db.get_tables(schema) if x[0] not in ('variables', )]

            # init alias index
            schema_alias_index = 0

            if tables:
                for t_i, table in enumerate(tables):
                    print('Collecting columns and IDs from {schema}.{table}'.format(schema=schema, table=table))
                    # collect IDs
                    schema_record_ids.update([x['id'] for x in db.get_column_values(schema=schema, table=table, column='id')])

                    # define aliases
                    schema_alias = string.ascii_letters[schema_alias_index]
                    model_alias = string.ascii_letters[model_alias_index]

                    # add full table identifier to tables list
                    schema_join_tables.append({'schema': schema, 'table': table, 'alias': schema_alias})
                    model_join_tables.append({'schema': schema, 'table': table, 'alias': model_alias})

                    # get columns
                    columns = db.get_columns(schema=schema, table=table)
                    for c_i, column in enumerate(columns):
                        # add to columns for SQL statement
                        if column not in ('id', ):
                            schema_select_columns.append('"{alias}"."{col}"'.format(alias=schema_alias, col=column))
                            model_select_columns.append('"{alias}"."{col}"'.format(alias=model_alias, col=column))

                    # increment alias index
                    schema_alias_index += 1
                    model_alias_index += 1

                # update global record ID st
                model_record_ids.update(schema_record_ids)

                # generate module level variables view
                schema_sql = sql_create.format(schema=schema, view='variables')
                schema_sql += '\n     , '.join(schema_select_columns)
                schema_sql += '\nFROM (VALUES ({ids})) "variables" ("variable")\n'.format(ids='), ('.join([str(x) for x in schema_record_ids]))
                schema_sql += '\n'.join(['FULL JOIN {schema_table: <{fill}}"{alias}" ON "variables"."variable" = "{alias}"."variable"'.format(fill=max([len(x['schema'] + x['table']) + 6 for x in schema_join_tables]),
                                                                                                                            schema_table='"{schema}"."{table}"'.format(**join_table),
                                                                                                                            alias=join_table['alias']
                                                                                                                            )
                                         for join_table in schema_join_tables]
                                        )
                schema_sql += sql_close

                # write schema view sql to file
                schema_fname_out = '{schema}.{view}.sql'.format(schema=schema, view='variables')
                with open(schema_fname_out, 'w') as schema_file_out:
                    schema_file_out.write(schema_sql)

print('complete!')
