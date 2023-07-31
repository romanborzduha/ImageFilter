//
//  LumaThresholdKernel.metal
//  ImageFilter
//
//  Created by Roman Borzdukha on 30.07.2023.
//

#include <metal_stdlib>
using namespace metal;

#include <CoreImage/CoreImage.h>
 
//extern "C" float4 LumaThresholdKernel(coreimage::sample_t pixelColor, float threshold, coreimage::destination destination)
//{
//    float3 pixelRGB = pixelColor.rgb;
//
//    float luma = (pixelRGB.r * 0.2126) + (pixelRGB.g * 0.7152) + (pixelRGB.b * 0.0722);
//
//    return (luma > threshold) ? float4(1.0, 1.0, 1.0, 1.0) : float4(0.0, 0.0, 0.0, 0.0);
//}

extern "C" {
  namespace coreimage {
    //2
      float4 tiktokfy(sampler s, float offset) {
          float2 coord = s.coord();
          float2 rOffset = float2(offset, offset);
          float2 gbOffset = float2(-offset, -offset);

          float3 rgb;
          rgb.r = s.sample(coord - rOffset).r;
          rgb.gb = s.sample(coord - gbOffset).gb;
          
          return float4(rgb, 1.0);
      }
  }
}
