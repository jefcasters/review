// Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

function init() {
    anno.makeAnnotatable(document.getElementById('annotatableImage'));
  }

function appendComment(itemToAppend){
  console.log(itemToAppend);
  $( "#image-comment-container" ).append(itemToAppend);

}

function showBox(text){
  alert(text);
}


anno.addHandler('onAnnotationCreated', function(annotation) {
  alert(JSON.stringify(annotation));
  jQuery.ajax({
    type: "POST",
    url: "/annotations",
    dataType: "JSON",
    data: "annotation="+JSON.stringify(annotation)
    });
});
