<%@page import="java.sql.*"%>
<%@page import="java.util.*, com.profile.bean.ProfileBean"%>
<%@page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>All Profiles</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body, html { height: 100%; 
                     margin: 0; 
                     padding: 0; }
        
        .bg-image { 
            background-image: url('assets/img/header-bg.jpg'); 
            background-size: cover; background-position: center; min-height: 100vh; }
        
        .overlay { background: rgba(0,0,0,0.55); 
                  min-height: 100vh; display: 
                      flex; align-items: center; justify-content: center; padding: 20px; }
        
        .card-custom { width: 100%; 
                      max-width: 1100px; 
                      border-radius: 15px; }
        
        .table thead { 
            background: linear-gradient(to right, 
                rgba(0,0,0,1), rgba(128,0,128,1)); 
            color: #fff; }
        
        .table-bordered td, .table-bordered th {
            border: 1px solid #dee2e6; }
        
        th, td { vertical-align: middle !important; 
                 text-align: 
                     center; }
        .btn-purple { background: linear-gradient(to right, rgba(0,0,0,1), rgba(128,0,128,1)); 
                     color: #fff; }
        
        .btn-edit { 
            color: #fff; background-color: #28a745; 
                   border-radius: 5px; 
                   padding: 5px 10px; }
        
        .btn-delete { 
            color: #fff; 
            background-color: #dc3545; 
            border-radius: 5px; 
            padding: 5px 10px; }
        
        .btn-edit:hover, .btn-delete:hover { 
            opacity: 0.85; }
        
        .search-container { 
            display: flex; 
            min-width: 200px; 
            max-width: 400px; 
            flex-grow: 0; }
        
        .search-container input { 
            flex-grow: 1; }
        
        .search-container button { 
            white-space: nowrap; }
        
        .d-flex select.form-select { 
            min-width: 150px; 
            max-width: 200px; 
            white-space: nowrap; 
            overflow: hidden; 
            text-overflow: ellipsis; }
        
        .btn-purple:hover {
        color: #fff !important; /* ensures the text stays white */
        opacity: 0.9; /* optional: slight hover effect */
    }
    </style>
</head>
<body>
    <div class="bg-image">
        <div class="overlay">
            <div class="card shadow-lg p-4 card-custom">


    <%
        // Load unique programs and hobbies
        List<String> programs = new ArrayList<String>();
        List<String> hobbies = new ArrayList<String>();
        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/profileInfo","app","app");
            Statement st = conn.createStatement();
            ResultSet rsProg = st.executeQuery("SELECT DISTINCT program FROM profiles");
            while(rsProg.next()) programs.add(rsProg.getString("program"));
            ResultSet rsHobby = st.executeQuery("SELECT DISTINCT hobbies FROM profiles");
            while(rsHobby.next()) hobbies.add(rsHobby.getString("hobbies"));
            conn.close();
        } catch(Exception e){ e.printStackTrace(); }

        ArrayList<ProfileBean> profiles = (ArrayList<ProfileBean>) request.getAttribute("profiles");
        String query = String.valueOf(request.getAttribute("query") != null ? request.getAttribute("query") : "");
        String programFilter = String.valueOf(request.getAttribute("programFilter") != null ? request.getAttribute("programFilter") : "");
        String hobbyFilter = String.valueOf(request.getAttribute("hobbyFilter") != null ? request.getAttribute("hobbyFilter") : "");
    %>

    <h2 class="text-center mb-4 text-uppercase">All Student Profiles</h2>

    <!-- Search & Filter Form -->
    <form method="get" action="viewProfiles" class="mb-3 d-flex align-items-center justify-content-between flex-wrap">
        <div class="d-flex flex-grow-1 me-3 search-container">
            <input type="text" name="query" placeholder="Search by Name or Student ID" value="<%=query%>" class="form-control">
            <button type="submit" class="btn btn-purple ms-2"><i class="fas fa-search"></i></button>
        </div>
        <div class="d-flex gap-2">
            <select name="programFilter" class="form-select" onchange="this.form.submit()">
                <option value="">All Programs</option>
                <% for(String p : programs) { %>
                    <option value="<%=p%>" <%= p.equals(programFilter) ? "selected" : "" %>><%=p%></option>
                <% } %>
            </select>
            <select name="hobbyFilter" class="form-select" onchange="this.form.submit()">
                <option value="" <%= (hobbyFilter==null || hobbyFilter.isEmpty()) ? "selected" : "" %>>All Hobbies</option>
                <% for(String h : hobbies) { if(h!=null && !h.trim().isEmpty()){ %>
                    <option value="<%=h%>" <%= h.equals(hobbyFilter) ? "selected" : "" %>><%=h%></option>
                <% } } %>
            </select>
        </div>
    </form>

    <% if(profiles == null || profiles.isEmpty()){ %>
    <p class="text-center text-muted">No profiles found in database.</p>
    <% } else { %>

    <div class="table-responsive">
        <table class="table table-striped table-hover table-bordered align-middle">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>Student ID</th>
                    <th>Program</th>
                    <th>Email</th>
                    <th>Hobbies</th>
                    <th>Introduction</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <% for(int i=0;i<profiles.size();i++){
                ProfileBean p = profiles.get(i); %>
                <tr>
                    <td><%=i+1%></td>
                    <td><%=p.getName()%></td>
                    <td><%=p.getStudentID()%></td>
                    <td><%=p.getProgram()%></td>
                    <td><%=p.getEmail()%></td>
                    <td><%=p.getHobbies()%></td>
                    <td><%=p.getIntro()%></td>
                    <td>
                        <a href="javascript:void(0);" class="btn btn-edit btn-sm mb-1"
                            onclick="openEditModal('<%=p.getStudentID()%>', '<%=p.getName()%>', '<%=p.getProgram()%>', '<%=p.getEmail()%>', '<%=p.getHobbies()%>', '<%=p.getIntro()%>')">
                            <i class="fas fa-pencil-alt"></i>
                        </a>
                        <a href="javascript:void(0);" class="btn btn-delete btn-sm mb-1"
                            onclick="confirmDelete('<%=p.getStudentID()%>')">
                            <i class="fas fa-trash"></i>
                        </a>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <% } %>

    <div class="text-center mt-3">
        <a href="index.html" class="btn btn-purple px-4">Back to Homepage</a>
    </div>

    <!-- Edit Modal -->
    <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <form id="editProfileForm" method="post" action="editProfile">
            <div class="modal-header">
              <h5 class="modal-title" id="editProfileModalLabel">Edit Profile</h5>
              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <input type="hidden" name="studentID" id="editStudentID">
                <div class="mb-3">
                    <label for="editName" class="form-label">Name</label>
                    <input type="text" class="form-control" id="editName" name="name" required>
                </div>
                <div class="mb-3">
                    <label for="editStudentID" class="form-label">Student ID</label>
                    <input type="text" class="form-control" id="editStudentID" name="studentID">
                </div>
                <div class="mb-3">
                    <label for="editProgram" class="form-label">Program</label>
                    <input type="text" class="form-control" id="editProgram" name="program">
                </div>
                <div class="mb-3">
                    <label for="editEmail" class="form-label">Email</label>
                    <input type="email" class="form-control" id="editEmail" name="email">
                </div>
                <div class="mb-3">
                    <label for="editHobbies" class="form-label">Hobbies</label>
                    <input type="text" class="form-control" id="editHobbies" name="hobbies">
                </div>
                <div class="mb-3">
                    <label for="editIntro" class="form-label">Introduction</label>
                    <textarea class="form-control" id="editIntro" name="intro"></textarea>
                </div>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
              <button type="submit" class="btn btn-success">Save Changes</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <script>
        function openEditModal(studentID, name, program, email, hobbies, intro){
            document.getElementById('editStudentID').value = studentID;
            document.getElementById('editName').value = name;
            document.getElementById('editProgram').value = program;
            document.getElementById('editEmail').value = email;
            document.getElementById('editHobbies').value = hobbies;
            document.getElementById('editIntro').value = intro;
            var myModal = new bootstrap.Modal(document.getElementById('editProfileModal'), {});
            myModal.show();
        }

        function confirmDelete(studentID){
            Swal.fire({
                title: 'Are you sure?',
                text: "This action cannot be undone!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#6c757d',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if(result.isConfirmed){
                    window.location.href = 'deleteProfile?studentID=' + studentID;
                }
            });
        }

        // Show SweetAlert success message if present
        <% String successMessage = (String) request.getSession().getAttribute("successMessage");
           if(successMessage != null){ %>
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: '<%= successMessage %>',
            timer: 2000,
            showConfirmButton: false
        });
        <% request.getSession().removeAttribute("successMessage"); } %>

    </script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
