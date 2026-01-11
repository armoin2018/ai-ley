import * as Camera from 'expo-camera';
import * as Location from 'expo-location';
import * as Notifications from 'expo-notifications';

// Request camera permissions
const { status } = await Camera.requestCameraPermissionsAsync();

// Get current location
const location = await Location.getCurrentPositionAsync({});

// Schedule notification
await Notifications.scheduleNotificationAsync({
  content: {
    title: 'Hello!',
    body: 'This is a test notification',
  },
  trigger: { seconds: 5 },
});