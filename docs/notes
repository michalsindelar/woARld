# ARKit notes
Resources
https://blog.markdaws.net/arkit-by-example-part1-7830677ef84d



## ARSCNView

*A view for displaying AR experiences that augment the camera view with 3D SceneKit content.*


- The world **coordinate** **system** of the view's SceneKit scene directly **responds** to the **AR world coordinate system** established by the session configuration.
- The view automatically moves its SceneKit camera to match the real-world movement of the device.

=> placing object to real world requires only SceneKit position



## ARWorldTrackingSessionConfiguration
- tells ARSession we want **six degrees of freedom**
![](https://d2mxuefqeaa7sj.cloudfront.net/s_A6B884960D7D4FC1923B55431122D92E5574BE8F7FF9CB86DB894CE88DC1985E_1509195044570_image.png)











- (ARSessionConfiguration if user still)




- ARKit and SceneKit coordinate system
  - camera faces in the negative Z direction



![](https://d2mxuefqeaa7sj.cloudfront.net/s_A6B884960D7D4FC1923B55431122D92E5574BE8F7FF9CB86DB894CE88DC1985E_1509195220143_image.png)



## SCNScene

*A scene graph—a hierarchy of nodes with attached geometries, lights, cameras and other attributes that together form a displayable 3D scene.*



**Lights**

`var lightingEnvironment: SCNMaterialProperty`

A **cube map texture** that depicts the environment surrounding the scene’s contents, used for advanced lighting effects.



- official tops
  - For realistic results, reuse the same contents for both the lighting environment and the `[background](https://developer.apple.com/documentation/scenekit/scnscene/1523665-background)` property.


**Fog**

- could be useful for simulating different environment
- all of them are **Animatable**


    var fogStartDistance: CGFloat
    var fogEndDistance: CGFloat
    var fogDensityExponent: CGFloat
    var fogColor: Any


**Particle Systems**
A **particle system** is a technique in [game physics](https://en.wikipedia.org/wiki/Game_physics), [motion graphics](https://en.wikipedia.org/wiki/Motion_graphics), and [computer graphics](https://en.wikipedia.org/wiki/3D_computer_graphics) that uses a large number of very small [sprites](https://en.wikipedia.org/wiki/Sprite_(computer_graphics)), [3D models](https://en.wikipedia.org/wiki/3D_model), or other graphic objects to simulate certain kinds of "fuzzy" phenomena

**Physics** 



## SCNNode

**Casts Shadow**




**CI Filters**

- tons of difital image processing tools

https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html


    CIBoxBlur
    CIDiscBlur
    CIGaussianBlur
    CIMaskedVariableBlur
    CIMedianFilter
    CIMotionBlur
    CINoiseReduction
    CIZoomBlur





# Plane Detection

:tldr: SIFT (Scale Invariant Feature transform)


## Problems
1. Poor lightning
2. Lack of texture
3. Fast movement 
  - in terms of blurred images



- is neabled with `ARWorldTrackingConfiguration()` `planeDetection` flag
  - after we start getting callbacks to delegate methods for the [ARSCNViewDelegate](https://developer.apple.com/documentation/arkit/arscnviewdelegate) protocol
  - `**func**` `renderer(_` `*renderer*``: SCNSceneRenderer,` `**didAdd | didUpdate**` ```*node*``: SCNNode, for` `*anchor*``: ARAnchor) {`
  - in these functions we handle planes




----------
# Development notes

😡 Storyboards have Dynamic cells by default therefor not visible anything after build
❗ Set to Static

![](https://d2mxuefqeaa7sj.cloudfront.net/s_A6B884960D7D4FC1923B55431122D92E5574BE8F7FF9CB86DB894CE88DC1985E_1509230282642_image.png)

## Data Management
1. Each scene should have own Controller
- keep in mind that `CustomClass` could be  set only for “compatible” superclasses


- e.g. `UITabController` could these Custom Class which extends `UITableViewController` 
- ❗ Only `ViewController` is not enough


![](https://d2mxuefqeaa7sj.cloudfront.net/s_A6B884960D7D4FC1923B55431122D92E5574BE8F7FF9CB86DB894CE88DC1985E_1509292625228_image.png)



2. How to handle global state
- **global** struct is not such a bad idea
- in controllers other controllers could be references




# Libraries Cooperation 


# 💣 Machine Learning & Vision

https://developer.apple.com/documentation/vision



## Vision framework

*Apply high-performance image analysis and computer vision techniques to identify faces, detect features, and classify scenes in images and video.*

😱 😱 😱 😱 
**

- provides Models of pretrained sets
  - dominant objects recognition
    - Inception v3
    - ResNet
    - VGG16
  - places
    - places205-GoogLeNet
![](https://d2mxuefqeaa7sj.cloudfront.net/s_A6B884960D7D4FC1923B55431122D92E5574BE8F7FF9CB86DB894CE88DC1985E_1509297173443_image.png)


😱 😱  **Woow**


https://www.youtube.com/watch?v=Sno-r2xQeRQ&


[https://youtu.be/Sno-r2xQeRQ](https://youtu.be/Sno-r2xQeRQ)



## Vuforia
- not supported yet
- according to official Vuforia docs in version 7 will come integration to ARKit 
  - framework **Vuforia Fusion** *(a new capability designed to provide the best possible AR experience on a wide range of devices)*
  - source: https://www.vuforia.com/press-releases/ptc-announces-major-new-release-to-vuforia-augmented-reality-platform.html




