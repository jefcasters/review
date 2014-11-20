// Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

function init() {
    anno.makeAnnotatable(document.getElementById('annotatableImage'));
    loadAnnotations();
  }

function appendComment(itemToAppend){
  console.log(itemToAppend);
  $( "#image-comment-container" ).append(itemToAppend);
  $("#comment_value").val("");

}

function showBox(text){
  alert(text);
}

//Annotation functions

anno.addHandler('onAnnotationCreated', function(annotation) {
  alert(JSON.stringify(annotation));
  jQuery.ajax({
    type: "POST",
    url: url_for_annotations,
    dataType: "script",
    data: "annotation="+JSON.stringify(annotation)
    });
});


function loadAnnotations() {
  jQuery.getJSON(url_for_annotations,function(data) {
    // annotations=JSON.parse();
    alert(data.annotations[83].json);
    annotations = JSON.parse(data.annotations[83].json);
    alert(annotations.text);
    for (var i = 0; i < data.annotations.length; i++){
      annotation = JSON.parse(data.annotations[i].json)
      console.log(annotation);
      if(annotation!=null){
        anno.addAnnotation(annotation);
      }
    }

    // alert(data.json);
    // var annotation = JSON.parse(data.json);
    // alert(annotation.text);
    // anno.addAnnotation(annotation);

    //alert(data[1].stringify);
    // for (var i = 0; i < data.length; i++) {
    //     annotation = JSON.parse(data[i].json)
    //     alert(annotation);
    //     if(annotation.isAnnotation == true){
    //       anno.addAnnotation(annotation);
    //     }

    //   }
  });
}
