/**
 * Created by sowmya on 1/14/17.
 */

$(document).ready(function() {

    $('#selectcat').on('change', function () {
        var cat = $('#selectcat').val();
        category = cat;
        $.post('AddProduct', {
            cat: cat
        }, function (data) {
            var result = $.parseJSON(data);
            var list = '';
            $.each(result, function (k, v) {
                list += "<li><a href='#"+v.sub_cat+"'>"+v.sub_cat +"</a></li>";
            });
            $('#subcat').html(list);
                $.post('ViewProduct', {
                         cat: cat
                     }, function (data) {
                     var result = $.parseJSON(data);
                     var option = '';
                     $.each(result, function (k,v){
                         option += '<div class="col-sm-6 col-md-4">';
                         option += '<div class="thumbnail">';
                         option += "<img src='"+v.image+"'>";
                         option += '<div class="caption">';
                         option += '<h4>'+v.product_name+'</h4>';
                         option += '<p>Cost: '+v.cost +'</p>';
                         option += "</div></div></div>";
                     });
                     $('#main').html(option);
                });
        });

    });
});