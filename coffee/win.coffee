module.exports = win = Ti.UI.createWindow
  backgroundColor: '#000'
  layout: 'vertical'

imageView = Ti.UI.createImageView
  width: 300
  height: 300

win.add imageView

galleryButton = Ti.UI.createButton
  title: 'open photo gallary'

imageFromEvent = null

galleryButton.addEventListener 'click', ->
  Ti.Media.openPhotoGallery
    success: (e) ->
      imageFromEvent = e.media
      imageView.setImage e.media
      return
    error: ->
      alert 'something went wrong'
      return
  return

win.add galleryButton

postButton = Ti.UI.createButton
  title: 'post'

sendImageFile = (image) ->
  activeIndicator = Ti.UI.createActivityIndicator
    message: 'posting...'

  xhr = Ti.Network.createHTTPClient()

  xhr.open 'POST', 'http://kaosf-ti-post-image.herokuapp.com/items'

  # xhr.setRequestHeader 'Content-Type', 'multipart/form-data'
  xhr.setRequestHeader 'Content-Type', 'application/json'

  xhr.onload = ->
    activeIndicator.hide()
    alert 'success posting'
    return
  xhr.onerror = (e) ->
    activeIndicator.hide()
    alert "error #{e}"
    return

  xhr.send (JSON.stringify
    item:
      title: 'title'
      photo: image
  )

  activeIndicator.show()
  return

postButton.addEventListener 'click', ->
  if imageFromEvent?
    sendImageFile imageFromEvent
  else
    alert 'image is not selected'
  return

win.add postButton
