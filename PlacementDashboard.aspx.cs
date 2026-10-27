
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace PlacementDashboard
{
    public partial class PlacementDashboard : System.Web.UI.Page
    {
        string cs =
            @"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=PlacementDB;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboard();
            }
        }

        private void LoadDashboard()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string statsQuery = @"
                    SELECT
                        COUNT(*) AS TotalStudents,
                        SUM(CASE WHEN IsPlaced = 1
                            THEN 1 ELSE 0 END) AS PlacedStudents,
                        SUM(CASE WHEN IsPlaced = 0
                            THEN 1 ELSE 0 END) AS NotPlaced,
                        (SELECT AVG(PackageLPA)
                         FROM Placements) AS AveragePackage
                    FROM Students";

                using (SqlCommand cmd =
                    new SqlCommand(statsQuery, con))
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        lblTotal.Text = dr["TotalStudents"].ToString();
                        lblPlaced.Text = dr["PlacedStudents"].ToString();
                        lblNotPlaced.Text = dr["NotPlaced"].ToString();

                        lblAverage.Text =
                            Convert.ToDecimal(dr["AveragePackage"])
                            .ToString("0.00");
                    }
                }

                string studentQuery = @"
                    SELECT
                        s.StudentId,
                        s.EnrollmentNo,
                        s.StudentName,
                        s.Department,
                        s.PassingYear,
                        CASE WHEN s.IsPlaced = 1
                            THEN 'Placed'
                            ELSE 'Not Placed'
                        END AS PlacementStatus,
                        p.CompanyName,
                        p.JobRole,
                        p.PackageLPA
                    FROM Students s
                    LEFT JOIN Placements p
                        ON s.StudentId = p.StudentId";

                SqlDataAdapter da =
                    new SqlDataAdapter(studentQuery, con);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvStudents.DataSource = dt;
                gvStudents.DataBind();

                string companyQuery = @"
                    SELECT
                        CompanyName,
                        COUNT(*) AS TotalPlacements,
                        AVG(PackageLPA) AS AveragePackage
                    FROM Placements
                    GROUP BY CompanyName";

                SqlDataAdapter da2 =
                    new SqlDataAdapter(companyQuery, con);

                DataTable dt2 = new DataTable();
                da2.Fill(dt2);

                gvCompanies.DataSource = dt2;
                gvCompanies.DataBind();

                foreach (GridViewRow row in gvCompanies.Rows)
                {
                    row.Cells[2].Text =
                        Convert.ToDecimal(row.Cells[2].Text).ToString("0.00") + "LPA";
                }
            }
        }
    }
}
