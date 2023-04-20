//= require jquery
//= require bootstrap-sprockets
//= require_self

$(".alert-success" ).fadeOut(6000);
$(".alert-danger" ).fadeOut(6000);
$(".alert" ).fadeOut(6000);

function iframeAutoScale() {

  'use strict';

  var
    iframes = document.getElementsByClassName('.img-square-wrapper'),
    index = 0;

  if (iframes.length > 0) {
    for (index = 0; index < iframes.length; index++) {
      var
        iframe = iframes[index],
        parent = iframe.parentElement,
        parentPadding = parseInt(window.getComputedStyle(parent, null).getPropertyValue('padding-left')) + parseInt(window.getComputedStyle(parent, null).getPropertyValue('padding-right')),
        parentWidth = parent.clientWidth - parentPadding,
        ratio = 2,	// default ratio (4:3)
        width = iframe.clientWidth,
        height = iframe.clientHeight;

      if (width !== undefined && height !== undefined) {
        ratio = height / width;
      }
      
      iframe.setAttribute('width', parentWidth);
      iframe.setAttribute('height', parentWidth * ratio);

    }
  }
}


// onload
document.addEventListener('DOMContentLoaded', function () { 
  var w = document.documentElement.clientWidth || window.innerWidth;
  if (w <= 837) {
    iframeAutoScale();
    var iframes = document.getElementsByTagName('iframe'),
      index = 0;
    if (iframes.length > 0) {
      for (index = 0; index < iframes.length; index++) {
        var
          iframe = iframes[index],
          parent = iframe.parentElement,
          parentPadding = parseInt(window.getComputedStyle(parent, null).getPropertyValue('padding-left')) + parseInt(window.getComputedStyle(parent, null).getPropertyValue('padding-right')),
          parentWidth = parent.clientWidth - parentPadding,
          ratio = 2,	// default ratio (4:3)
          width = iframe.clientWidth,
          height = iframe.clientHeight;

        iframe.setAttribute('width', "100%");
        var newWidth = iframe.clientWidth;
        iframe.setAttribute('height', newWidth/2);
      }
    }
  }
}, false);

// on window resize
window.onresize = function(event) {
  var w = document.documentElement.clientWidth || window.innerWidth;
  if (w <= 837) {
    iframeAutoScale();
    var iframes = document.getElementsByTagName('iframe'),
      index = 0;
    if (iframes.length > 0) {
      for (index = 0; index < iframes.length; index++) {
        var
          iframe = iframes[index],
          parent = iframe.parentElement,
          parentPadding = parseInt(window.getComputedStyle(parent, null).getPropertyValue('padding-left')) + parseInt(window.getComputedStyle(parent, null).getPropertyValue('padding-right')),
          parentWidth = parent.clientWidth - parentPadding,
          ratio = 2,	// default ratio (4:3)
          width = iframe.clientWidth,
          height = iframe.clientHeight;

        iframe.setAttribute('width', "100%");
        var newWidth = iframe.clientWidth;
        iframe.setAttribute('height', newWidth/2);
      }
    }
  }
};