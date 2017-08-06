/**
 * Created by sowmya on 1/9/17.
 */
$(document).ready(function(){
   $('input[name=addsubcat]').on('click',function () {
        var cat= $('#selectcat').val();
        var subcat= $('input[name=subcat]').val();
        $.post('AddSubcat',{
            cat:cat,
            subcat:subcat
        },function (data) {
            if(data=="1"){
                alert("Data Recorded");
            }else{
                alert("Something went wrong");
            }
        });
   });

    $('#upload_image').ajaxForm({
        success: function(msg) {
            alert("File has been uploaded successfully");
            window.location="OwnerHome.jsp";
        },
        error: function(msg) {
            $("#upload-error").text("Couldn't upload file");
        }
    });
});
