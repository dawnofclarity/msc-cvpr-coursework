# msc-cvpr-coursework

Investigation files used for CVPR Coursework

Edit the file Config.m and set the following as required for your machine:
    DATASET_FOLDER = 'Y:\cvpr\msrc_objcategimagedatabase_v2';
    DESCRIPTOR_FOLDER = 'Y:\cvpr\descriptors';

Ensure that the CVPR lab code is on the matlab path (via set path) for the Eigen classes.

Ensure the following directories exist in the descriptors directory:
    globalRGB
    globalRGBhistoQ10
    globalRGBhistoQ12
    globalRGBhistoQ14
    globalRGBhistoQ16
    globalRGBhistoQ2
    globalRGBhistoQ3
    globalRGBhistoQ4
    globalRGBhistoQ6
    globalRGBhistoQ8
    griddedColourG10
    griddedColourG12
    griddedColourG14
    griddedColourG16
    griddedColourG2
    griddedColourG3
    griddedColourG4
    griddedColourG6
    griddedColourG8
    griddedTextureColourQ10G10
    griddedTextureColourQ10G12
    griddedTextureColourQ10G6
    griddedTextureColourQ10G8
    griddedTextureColourQ6G10
    griddedTextureColourQ6G12
    griddedTextureColourQ6G6
    griddedTextureColourQ6G8
    griddedTextureColourQ8G10
    griddedTextureColourQ8G12
    griddedTextureColourQ8G6
    griddedTextureColourQ8G8
    griddedTextureQ10
    griddedTextureQ12
    griddedTextureQ14
    griddedTextureQ16
    griddedTextureQ2
    griddedTextureQ3
    griddedTextureQ4
    griddedTextureQ6
    griddedTextureQ8

Generate the descriptors by running the following scripts:
    makeGlobalRGB.m
    makeGlobalRGBhisto.m
    makeGriddedColour.m
    makeGriddedTexture.m
    makeGriddedTextureColour.m

Run the relevant test script:
    test<descriptor><comparator>        Single search (random image selection)
    test<descriptor><comparator>All     All searches to provide a PR graph
    test<descriptor><comparator>AllEx   All searches with variations to provide multi line PR graphs (these take a while to run!)

Also included are explain<thing> scripts, used to create the figures used in the report.

GroundTruth mapping is cunningly concealed in the file GroundTruthClass.m
