// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


function doMasonryMagic(){
  var container = document.querySelector('#masonry-container');
    var msnry = new Masonry( container, {
    // options
    columnWidth: 50,
    itemSelector: '.index-item',
  });
}



