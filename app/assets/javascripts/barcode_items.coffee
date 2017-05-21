# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#barcode_item_value").on "change", (e) ->
    value = e.target.value
    organization_id = $(e.target).data('organization_id')
    $.ajax
      url: "/#{organization_id}/barcode_items/find?value=#{value}"
      dataType: "json"
      success: (data) ->
        if data
          $("#barcode-input-package-count").val(data.quantity)
          $("#barcode_item_item_id").val(data.item_id)
          $("#barcode_item_value").removeClass( "field-validation-error" )
        else
          $("#barcode_item_value").addClass( "field-validation-error" )
          $("#barcode_item_quantity").val(null)
          $("#barcode_item_item_id").val(null)
