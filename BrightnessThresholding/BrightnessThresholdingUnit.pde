color[] BrightnessThredholding(color[] pixelData, int threshold){
  float pixelBrightness; // Declare variable to store a pixel's color
  
  //Number of Pixels
  int numPixels = pixelData.length;
  //Declare return variable.
  color[] outputPixelData = new color[numPixels];
  
  // Turn each pixel in the video frame black or white depending on its brightness
  for (int i = 0; i < numPixels; i++) {
    pixelBrightness = brightness(video.pixels[i]);
    if (pixelBrightness > threshold) { // If the pixel is brighter than the
      outputPixelData[i] = white; // threshold value, make it white
    } 
    else { // Otherwise,
      outputPixelData[i] = black; // make it black
    }
  }
  
  return outputPixelData;
}
