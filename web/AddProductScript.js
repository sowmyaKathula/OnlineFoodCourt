/**
 * Created by sowmya on 1/10/17.
 */

$(document).ready(function(){

    $('#selectcat').on('change', function() {
        var cat= $('#selectcat').val();
        category = cat;
        $.post('AddProduct',{
            cat:cat
        },function (data) {
            var result = $.parseJSON(data);
            var options='<option value="NONE">--------- Select Any Sub-Category ---------</option>';
            $.each(result, function(k,v){
                console.log(v.sub_cat +" " +v.subcat_id);
                options+="<option value="+v.subcat_id+">"+v.sub_cat+"</option>";
                console.log(options);
            });
            $('#SubCat').html(options);
        });
    });

    $('#product_Form').ajaxForm({
        success: function(msg) {
            alert("File has been uploaded successfully");
            window.location="OwnerHome.jsp";
        },
        error: function(msg) {
            $("#upload-error").text("Couldn't upload file");
        }
    });

    $('#product_Form').validate({
        rules: {
            selectcat: {
                required: true
            },
            SubCat: {
                required: true
            },
            product_name: {
                required: true
            },
            description: {
                required: true
            },
            cost: {
                required: true,
                number: true
            },
            in_stock: {
                required: true,
                number: true
            },
            type_product: {
                required: true
            }
        }
    });
});