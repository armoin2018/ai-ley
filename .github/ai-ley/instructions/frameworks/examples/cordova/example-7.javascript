// Using device plugin
document.addEventListener('deviceready', function () {
  console.log('Device Platform: ' + device.platform);
  console.log('Device Version: ' + device.version);
  console.log('Device Model: ' + device.model);
  console.log('Device UUID: ' + device.uuid);
});

// Using camera plugin
function takePicture() {
  const options = {
    quality: 75,
    destinationType: Camera.DestinationType.FILE_URI,
    sourceType: Camera.PictureSourceType.CAMERA,
    encodingType: Camera.EncodingType.JPEG,
    targetWidth: 300,
    targetHeight: 300,
  };

  navigator.camera.getPicture(onSuccess, onFail, options);
}

function onSuccess(imageURI) {
  const image = document.getElementById('myImage');
  image.src = imageURI;
}

function onFail(message) {
  alert('Failed to capture image: ' + message);
}