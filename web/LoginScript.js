/**
 * Created by sowmya on 1/5/17.
 */

$(document).ready(function() {


    $('#loginForm').validate({
        rules: {
            phone: {
                required: true,
                minlength: 9,
                maxlength: 10,
                number: true
            },
            password: {
                required: true
            },
            messages: {
                password: "Please enter your password..!",
                phone: "Enter your mobile no"
            }
        },
        submitHandler: function (form) {
            test();
        }
    });

    $('#signupform').validate({
        rules: {
            sname: {
                required: true,
            },
            semail: {
                email: true,
            },
            sphone: {
                required: true,
                minlength: 10,
                maxlength: 10,
                number: true
            },
            password: {
                required: true
            }
        },
        submitHandler: function (form) {
            alert("ok");
            test1();
        }
    });
});




function test(){
    $.post("LoginServlet",
    {
        phone: $('#phone').val(),
        password: $('#pwd').val()

    },
    function(data,status) {
        if(data==2){
            alert("Login Successsfull");
            window.location="OwnerHome.jsp";
        }else if(data==1){
            alert("Login Successful");
            location.reload();
        }
        else if(data==0){
            alert("Wrong Password");
        }
        else{
            alert("Not a Registered User");
        }
    });
}


function test1(){
    $.post("EndUserRegisterServlet",{
        sname: $('#sname').val(),
        semail: $('#semail').val(),
        sphone: $('#sphone').val(),
        spassword: $('#spassword').val()
    },
    function(data,status){
       if(data==1){
           alert("Registration Successfull");
           window.location="Home.jsp";
       }
       else{
           alert("Registration failed");
       }
    });
}