using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SOICAU
{
    public partial class FindNumber : Form
    {

        public FindNumber()
        {
            InitializeComponent();
        }

        private void FindNumber_Load(object sender, EventArgs e)
        {
            new bachthu().BACHTHU();
        }



    }
}
