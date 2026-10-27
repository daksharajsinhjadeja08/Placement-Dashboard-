
<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="PlacementDashboard.aspx.cs"
    Inherits="PlacementDashboard.PlacementDashboard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Placement Dashboard</title>
</head>
<body>
    <form id="form1" runat="server">

        <h1>College Placement Dashboard</h1>

        <h2>Placement Statistics</h2>

        <p>Total Students:
            <asp:Label ID="lblTotal" runat="server" />
        </p>

        <p>Placed Students:
            <asp:Label ID="lblPlaced" runat="server" />
        </p>

        <p>Not Placed:
            <asp:Label ID="lblNotPlaced" runat="server" />
        </p>

        <p>Average Package (LPA):
            <asp:Label ID="lblAverage" runat="server" />
        </p>

        <h2>Student Placement Details</h2>

        <asp:GridView ID="gvStudents" runat="server"
            AutoGenerateColumns="true">
        </asp:GridView>

        <h2>Company-wise Placements</h2>

        <asp:GridView ID="gvCompanies" runat="server"
            AutoGenerateColumns="true">
        </asp:GridView>

    </form>
</body>
</html>
