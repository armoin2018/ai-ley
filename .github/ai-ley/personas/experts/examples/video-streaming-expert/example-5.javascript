const peerConnection = new RTCPeerConnection({
  iceServers: [{ urls: 'stun:stun.l.google.com:19302' }],
  bundlePolicy: 'max-bundle',
  rtcpMuxPolicy: 'require',
  encodedInsertableStreams: true
});

// Optimize for low latency
peerConnection.addTransceiver('video', {
  direction: 'sendrecv',
  sendEncodings: [{
    maxBitrate: 2500000,
    scaleResolutionDownBy: 1
  }]
});