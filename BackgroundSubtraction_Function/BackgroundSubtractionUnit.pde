/**
 * @fn subtractBg
 * @param pixelData inputPixelData
 * @param bgPixelData  backgroundPixelData
 * @brief Function for Background Subtraction.
 * Detect the presence of people and objects in the frame using a simple
 * background-subtraction technique. To initialize the background, press a key.
 * @author Golan Levin, Kenichi Yorozu
 * @date 4th May 2012
 */
color[] subtractBg(color[] pixelData, color[] bgPixelData){
  //Declare return variable;
  color[] outputPixelData = new color[numPixels];
  
  // Difference between the current frame and the stored background
  for (int i = 0; i < numPixels; i++) { // For each pixel in the video frame...
    // Fetch the current color in that location, and also the color
    // of the background in that spot
    color currColor = pixelData[i];//video.pixels[i];
    color bgColor = bgPixelData[i];
    // Extract the red, green, and blue components of the current pixel’s color
    int currR = (currColor >> 16) & 0xFF;
    int currG = (currColor >> 8) & 0xFF;
    int currB = currColor & 0xFF;
    // Extract the red, green, and blue components of the background pixel’s color
    int bgR = (bgColor >> 16) & 0xFF;
    int bgG = (bgColor >> 8) & 0xFF;
    int bgB = bgColor & 0xFF;
    // Compute the difference of the red, green, and blue values
    int diffR = abs(currR - bgR);
    int diffG = abs(currG - bgG);
    int diffB = abs(currB - bgB);
    // Add these differences to the running tally
    // Render the difference image to the screen
    //pixels[i] = color(diffR, diffG, diffB);
    // The following line does the same thing much faster, but is more technical
    outputPixelData[i] = 0xFF000000 | (diffR << 16) | (diffG << 8) | diffB;
  }
  
  return outputPixelData;
}
