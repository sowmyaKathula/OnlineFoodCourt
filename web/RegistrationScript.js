/**
 * Created by sowmya on 1/4/17.
 */

$(document).ready(function() {
    $('#password').keyup(function() {
        var pswd = $(this).val();
        if ( pswd.length < 8 ) {
            $('#length').removeClass('valid').addClass('invalid');
        } else {
            $('#length').removeClass('invalid').addClass('valid');
        }
        //validate letter
        if ( pswd.match(/[A-z]/) ) {
            $('#letter').removeClass('invalid').addClass('valid');
        } else {
            $('#letter').removeClass('valid').addClass('invalid');
        }

        //validate capital letter
        if ( pswd.match(/[A-Z]/) ) {
            $('#capital').removeClass('invalid').addClass('valid');
        } else {
            $('#capital').removeClass('valid').addClass('invalid');
        }

        //validate number
        if ( pswd.match(/\d/) ) {
            $('#number').removeClass('invalid').addClass('valid');
        } else {
            $('#number').removeClass('valid').addClass('invalid');
        }
    }).focus(function() {
        $('#pswd_info').show();
    }).blur(function() {
        $('#pswd_info').hide();
    });
    $('#registerForm').validate({
        rules: {
            location:{
                required: true
            },
            restaurantName:{
                required: true
            },
            noOutlets:{
                required: true,
                number: true
            },
            details:{
                required: "#other:checked"
            },
            name:{
                required: true
            },

            contact: {
                required: true,
                minlength: 10,
                maxlength: 10,
                number: true
            },
            email: {
                email:true,
                required: true
            },
            password: {
                required: true,
                depends : passwordValidate()
            },
            conformpass: {
                required:true,
                equalTo:"#password"
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
});

function passwordValidate(){
    var pswd = $('#password').val();
    if(pswd.length < 8 && pswd.match(/[A-z]/) && pswd.match(/[A-Z]/) && pswd.match(/\d/)){
        return true;
    }
    return false;
}


function test(){
    var test=$('input[name=cuisine]:checked').map(function()
    {
        return $(this).val();
    }).get();

    var x=$('#other:checked').map(function(){
        return $('#details').val();
    }).get();

    test.pop();
    test.push(x[0]);
    $.post("RegisterServlet",
        {
            location: $('#location').val(),
            restaurantName: $('#restaurantName').val(),
            noOutlets: $('#noOutlets').val(),
            name: $('#name').val(),
            contact: $('#contact').val(),
            password: $('#password').val(),
            emailaddr: $('#emailaddr').val(),
            cuisine: test

        },
        function(data,status) {
            if(data==1){
                alert("ok");
              window.location="Home.jsp";
                test1();
            }else{
                alert("Not ok");

            }
        });
};


function test1(){
    $(document).ready(function() {
        alert("success");
        $("#success").modal({show:true});
    });
}









