using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SOICAU
{
    public static class DataTableExtentions
    {
        public static List<int> ToColumListInt(this DataTable dt, string col)
        {
            var result = new List<int>();

            foreach (DataRow item in dt.Rows)
            {
                string BT = item[col].ToString();
                result.Add(int.Parse(BT));
            }
            return result;
        }
        public static int GetInt(this DataRow row, string col)
        {
            if (row== null)
            {
                return -1;
            }
            string BT = row[col].ToString();
            if (string.IsNullOrEmpty(BT))
            {
                return -1;
            }
            return int.Parse(BT);
        }
        public static string FirstOrDefault(this DataTable data, string Column)
        {
            string result = "";
            if (data != null && data.Rows.Count > 0)
            {
                result = data.Rows[0][Column].ToString();
            }
            return result;
        } 
        public static DataRow FirstOrDefault(this DataTable data)
        {
            DataRow result = null;
             if ( data.Rows.Count > 0)
            {
                result = data.Rows[0];
            }
            return result;
        }
        public static string FirstOrDefault(this DataTable data, int ColumnIndex)
        {
            string result = "";
            if (data != null && data.Rows.Count > 0)
            {
                result = data.Rows[0][ColumnIndex].ToString();
            }
            return result;
        }
    }
}
