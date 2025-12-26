<%@page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Profile Summary</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
      .profile-pic {
          width: 120px;
          height: 120px;
          object-fit: cover;
          border-radius: 50%;
          border: 4px solid #ffffff;
          box-shadow: 0 4px 10px rgba(0,0,0,0.2);
      }
      .card-custom {
          max-width: 500px;   /* LIMIT WIDTH */
          margin: auto;       /* CENTER IT */
      }
        .btn-purple { 
        background: linear-gradient(to right, rgba(0,0,0,1), rgba(128,0,128,1)); 
                         color: #fff; }

        .btn-purple:hover {
        color: #fff !important; /* ensures the text stays white */
        opacity: 0.9; /* optional: slight hover effect */
    }


  </style>
</head>
<body>
    <section class="vh-100 bg-image"
        style="background-image: url('assets/img/header-bg.jpg');">

        <div class="mask d-flex align-items-center h-100 gradient-custom-3">
            <div class="container h-100">

                <div class="row d-flex justify-content-center align-items-center h-100">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6">

              <div class="container mt-5">
                    <!-- CIRCLE PROFILE IMAGE -->
                <div class="d-flex justify-content-center mb-4">
                    <img 
                      src="https://ui-avatars.com/api/?name=${profile.name}&background=BF40BF&color=fff&size=200"
                      alt="Profile Picture"
                      class="profile-pic"
                    />
                </div>
              <div class="card shadow-sm p-4 text-center card-custom">

                <h2 class="text-center mb-4">Profile Summary</h2>

                <table class="table table-striped text-start">
                  <tbody>
                    <tr><th>Name</th><td>${profile.name}</td></tr>
                    <tr><th>Student ID</th><td>${profile.studentID}</td></tr>
                    <tr><th>Program</th><td>${profile.program}</td></tr>
                    <tr><th>Email</th><td>${profile.email}</td></tr>
                    <tr><th>Hobbies</th><td>${profile.hobbies}</td></tr>
                    <tr><th>Introduction</th><td>${profile.intro}</td></tr>
                  </tbody>
                </table>

                <a href="index.html" class="btn btn-purple w-100 mt-2">Back to Homepage</a>

                

              </div>
            </div>

                    </div>
                </div>

            </div>
        </div>

    </section>

    <!-- MDB Bootstrap JS -->
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>
