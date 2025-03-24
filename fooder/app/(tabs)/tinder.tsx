import { Text, View, StyleSheet } from 'react-native';

import ImageViewer from '@/components/tinder/imageViewer';

const PlaceholderImage = require('@/assets/images/ramen.jpg');

export default function tinderScreen() {
  return (
    <View style={styles.container}>
      <ImageViewer imgSource={PlaceholderImage} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#25292e',
    justifyContent: 'center',
    alignItems: 'center',
  },
  text: {
    color: '#fff',
  },
});
