var galleryButton, imageFromEvent, imageView, postButton, sendImageFile, win;

module.exports = win = Ti.UI.createWindow({
  backgroundColor: '#000',
  layout: 'vertical'
});

imageView = Ti.UI.createImageView({
  width: 300,
  height: 300
});

win.add(imageView);

galleryButton = Ti.UI.createButton({
  title: 'open photo gallary'
});

imageFromEvent = null;

galleryButton.addEventListener('click', function() {
  Ti.Media.openPhotoGallery({
    success: function(e) {
      imageFromEvent = e.media;
      imageView.setImage(e.media);
    },
    error: function() {
      alert('something went wrong');
    }
  });
});

win.add(galleryButton);

postButton = Ti.UI.createButton({
  title: 'post'
});

sendImageFile = function(image) {
  var activeIndicator, xhr;
  activeIndicator = Ti.UI.createActivityIndicator({
    message: 'posting...'
  });
  xhr = Ti.Network.createHTTPClient();
  xhr.open('POST', 'http://kaosf-ti-post-image.herokuapp.com/items');
  xhr.setRequestHeader('Content-Type', 'application/json');
  xhr.onload = function() {
    activeIndicator.hide();
    alert('success posting');
  };
  xhr.onerror = function(e) {
    activeIndicator.hide();
    alert("error " + e);
  };
  xhr.send(JSON.stringify({
    item: {
      title: 'title',
      photo: image
    }
  }));
  activeIndicator.show();
};

postButton.addEventListener('click', function() {
  if (imageFromEvent != null) {
    sendImageFile(imageFromEvent);
  } else {
    alert('image is not selected');
  }
});

win.add(postButton);
