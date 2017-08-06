/**
 * Created by sowmya on 1/16/17.
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
                var modal = '';
                $.each(result, function (k,v){
                    option += '<div class="col-sm-6 col-md-4">';
                    option += '<div class="thumbnail">';
                    option += "<img src='"+v.image+"'>";
                    option += '<div class="caption">';
                    option += '<h4>'+v.product_name+'</h4>';
                    option += '<p>Cost: '+v.cost +'</p>';
                    option += '<a href="#EditModal'+v.product_id+'" data-toggle="modal" data-backdrop = "false">Edit</a>';
                    option += '<a href="#DeleteModal'+v.product_id+'" data-toggle="modal" data-backdrop = "false" class="pull-right">Delete</a>';
                    option += "</div></div></div>";
                    modal += '<div class = "modal fade" id="EditModal'+v.product_id+'" role="dialog">';
                    modal += '<div class="modal-dialog"><div class="modal-content">';
                    modal += '<form id="edit_form" action="EditProduct" method="post">';
                    modal += '<div class="modal-header"><button type="button" class="close" data-dismiss="modal">&times;</button>';
                    modal += '<h4 align=center>Edit Product</h4></div>';
                    modal += '<h5>'+v.product_name+'</h5>';
                    modal += '<div class = "model-body" id="EditProduct">';
                    modal += '<input type="hidden" name="product_id" value="'+v.product_id+'">';
                    modal += '<input type="hidden" name="product_name" value="'+v.product_name+'">';
                    modal += '<div class="form-group"><label class =" control-label">Description:</label>';
                    modal += '<input type="text" class="form-control" name="description" id="description" value="'+v.description+'" > </div>';
                    modal += '<div class="form-group"><label class = "control-label">Cost:</label>';
                    modal += '<input type = "text" class="form-control" name="cost" id="cost" value="'+v.cost+'"></div>';
                    modal += '<div class="form-group"><label class = "control-label">InStock:</label>';
                    modal += '<input type="text" class="form-control" name="in_stock" id="in_stock" value="'+v.instock+'"></div>';
                    modal += '<input type="submit" id="updateproduct" value="Edit Product" class="btn btn-success">';
                    modal += '</div></form></div></div></div>';
                    modal += '<div class = "modal fade" id="DeleteModal'+v.product_id+'" role="dialog">';
                    modal += '<div class="modal-dialog"><div class="modal-content">';
                    modal += '<form id="delete_form" action="DeleteProduct" method="post">';
                    modal += '<div class="modal-header"><button type="button" class="close" data-dismiss="modal">&times;</button>';
                    modal += '<h4 align=center>Delete Product</h4></div>';
                    modal += '<h5>'+v.product_name+'</h5>';
                    modal += '<div class = "model-body" id="EditProduct">';
                    modal += '<p>Do you want to delete this product</p>';
                    modal += '<input type="hidden" name="product_id" value="'+v.product_id+'">';
                    modal += '<input type="submit" id="updateproduct" value="Confirm Delete" class="btn btn-success">';
                    modal += '</div></form></div></div></div>';
                });
                console.log(option+modal);
                $('#main').html(option+modal);
            });
        });

    });

});










