import coremltools

# Convert a caffe model to a classifier in Core ML
caffe_model = ('oxford102.caffemodel', 'deploy.prototxt')
labels = 'flower-labels.txt'

coreml_model = coremltools.converters.caffe.convert(
    caffe_model,
    class_labels = labels,
    image_input_names='data'
)

# Now save the model
coreml_model.save('FlowerClassifier.mlmodel')