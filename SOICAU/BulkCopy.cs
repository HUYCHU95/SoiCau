using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SOICAU
{
    public class BulkCopy
    {

        static string StrConnection = @"Data Source=.\SQLEXPRESS;Initial Catalog=SC;Trusted_Connection=True;";
        public void BulkInsertAll(DataTable table, string tbName)
        {
             using (var conn = new SqlConnection(StrConnection))
            {
                conn.Open();
                var bulkCopy = new SqlBulkCopy(conn)
                {
                    DestinationTableName = tbName
                };
                int bulkCopyTimeout = 100000000;

                bulkCopy.BulkCopyTimeout = bulkCopyTimeout;

                bulkCopy.WriteToServer(table);
            }
        }
        public void BulkInsertAll<T>(IEnumerable<T> entities, string tbName)
        {
             using (var conn = new SqlConnection(StrConnection))
            {
                conn.Open();

                Type t = typeof(T);

                var bulkCopy = new SqlBulkCopy(conn)
                {
                    DestinationTableName = tbName
                };

                var properties = t.GetProperties().ToArray();
                var table = new DataTable();

                foreach (var property in properties)
                {
                    Type propertyType = property.PropertyType;
                    if (propertyType.IsGenericType &&
                        propertyType.GetGenericTypeDefinition() == typeof(Nullable<>))
                    {
                        propertyType = Nullable.GetUnderlyingType(propertyType);
                    }

                    table.Columns.Add(new DataColumn(property.Name, propertyType));
                }
                int a = 0;
                foreach (var entity in entities)
                {
                    table.Rows.Add(
                        properties.Select(
                        property => property.GetValue(entity, null) ?? DBNull.Value
                        ).ToArray());
                    a++;
                }
                int bulkCopyTimeout = 100000000;

                bulkCopy.BulkCopyTimeout = bulkCopyTimeout;

                bulkCopy.WriteToServer(table);
            }
        }

        
    }
}
