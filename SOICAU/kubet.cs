using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SOICAU
{
    public partial class kubet : Form
    {
        public kubet()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {

            var listrom = richTextBox1.Text.Split(';');
            foreach (var itemx in listrom)
            {
                var path = System.AppDomain.CurrentDomain.BaseDirectory;

                var data = itemx.Replace(";", " ").Replace("\n", " ").Replace("\t", " ").Split(' ').Where(z => z == "C" || z == "L").ToList();
                string newfile = path + @"\file\" + DateTime.Now.ToString("yyyyMMddHHmmss") + Guid.NewGuid().ToString() + ".xlsx";

                var fi = new FileInfo(path + @"\bet.xlsx");

                using (ExcelPackage excel = new ExcelPackage())
                {
                    using (FileStream stream = new FileStream(fi.FullName, FileMode.Open))
                    {
                        excel.Load(stream);
                        int recordRow = 1;
                        var workbook = excel.Workbook;
                        var ws = workbook.Worksheets.FirstOrDefault();

                        foreach (var item in data)
                        {
                            ws.Cells[recordRow, 3].Value = item;
                            recordRow++;
                        }
                        MemoryStream ms = new MemoryStream();
                        byte[] bdata = excel.GetAsByteArray();



                        File.WriteAllBytes(newfile, bdata);


                    }
                }


                using (ExcelPackage excel = new ExcelPackage())
                {
                    using (FileStream stream = new FileStream(newfile, FileMode.Open))
                    {
                        excel.Load(stream);
                        var workbook = excel.Workbook;
                        var ws = workbook.Worksheets.FirstOrDefault();


                        var von = ws.Cells[1, 2].Value.ToString();
                        var Lai = ws.Cells[2, 2].Value;
                        var Max1Step = ws.Cells[3, 2].Value;
                        var MaxLai = ws.Cells[4, 1].Value;
                        var MinLai = ws.Cells[3, 1].Value;
                        string sql = $@"INSERT INTO [dbo].[KUBET]
           ([KQ]
           ,[Von]
           ,[Lai]
           ,[Max1Step]
           ,[MaxLai]
           ,[MinLai]
           ,[UrlFile] )
     VALUES
           ('{string.Join(" ", data)}'
           ,{von}
           ,{Lai}
           ,{Max1Step}
           ,{MaxLai}
           ,{MinLai}
           ,'{newfile}'
           )";
                        SqlModule.ExcuteCommand(sql);


                    }
                }
                //   button2_Click(sender, e);
                System.Diagnostics.Process.Start(newfile);
            }

        }

        private void button2_Click(object sender, EventArgs e)
        {
            var data = SqlModule.GetDataTable("SELECT  KQ from [KUBET] group by KQ");
            dataGridView1.DataSource = data;
        }

        private void button3_Click(object sender, EventArgs e)
        {

            var data = richTextBox1.Text.Replace(";", " ").Replace("\n", " ").Replace("\t", " ").Split(' ').ToList();
            var newdata = data.Select(z => new { KQ = z.Split('-').FirstOrDefault(), ID = z.Split('-').LastOrDefault() });
            newdata = newdata.Where(z => z.KQ == "C" || z.KQ == "L").Distinct().OrderBy(Z => Z.ID).ToList();

            var room = newdata.Select(z => z.ID.Substring(7, 4)).Distinct().ToList();
            foreach (var item in room)
            {
                richTextBox1.Text = string.Join(" ", newdata.Where(z=>z.ID.Substring(7,4)==item).Select(z => z.KQ).ToList());
                button1_Click(sender, e);
            }


        }

        private void richTextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void dataGridView1_DoubleClick(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            string arg = dataGridView1.Rows[e.RowIndex].Cells["KQ"].Value.ToString();
            richTextBox1.Text = arg;
            button1_Click(sender, e);

        }

        private void button4_Click(object sender, EventArgs e)
        {

            var data = richTextBox1.Text.Replace(";", " ").Replace("\n", " ").Replace("\t", " ").Split(' ').ToList();
            var newdata = data.Select(z => new { KQ = z.Split('-').FirstOrDefault(), ID = z.Split('-').LastOrDefault() });
            newdata = newdata.Where(z => z.KQ == "0" || z.KQ == "1"|| z.KQ == "2"|| z.KQ == "3"|| z.KQ == "4").Distinct().OrderBy(Z => Z.ID).ToList();

            var room = newdata.Select(z => z.ID.Substring(7, 4)).Distinct().ToList();
            foreach (var item in room)
            {
                richTextBox1.Text = string.Join(" ", newdata.Where(z => z.ID.Substring(7, 4) == item).Select(z => z.KQ).ToList());
                button5_Click(sender, e);
            }

        }

        private void button5_Click(object sender, EventArgs e)
        {

            var listrom = richTextBox1.Text.Split(';');
            foreach (var itemx in listrom)
            {
                var path = System.AppDomain.CurrentDomain.BaseDirectory;

                var data = itemx.Replace(";", " ").Replace("\n", " ").Replace("\t", " ").Split(' ').Where(z => z == "0" || z == "1" || z == "2" || z == "3" || z == "4").ToList();
                string newfile = path + @"\file\" + DateTime.Now.ToString("yyyyMMddHHmmss") + Guid.NewGuid().ToString() + ".xlsx";

                var fi = new FileInfo(path + @"\theovi.xlsx");

                using (ExcelPackage excel = new ExcelPackage())
                {
                    using (FileStream stream = new FileStream(fi.FullName, FileMode.Open))
                    {
                        excel.Load(stream);
                        int recordRow = 3;
                        var workbook = excel.Workbook;
                        var ws = workbook.Worksheets.FirstOrDefault();

                        foreach (var item in data)
                        {
                            ws.Cells[recordRow, 1].Value =int.Parse(item);
                            recordRow++;
                        }
                        MemoryStream ms = new MemoryStream();
                        byte[] bdata = excel.GetAsByteArray();



                        File.WriteAllBytes(newfile, bdata);


                    }
                }

                System.Diagnostics.Process.Start(newfile);
            }
        }
    }
}
