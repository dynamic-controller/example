function(request) {
  local cm = request.object,

  local pod = {
    apiVersion: 'v1',
    kind: 'Pod',
    metadata: {
      name: cm.metadata.name,
      namespace: cm.metadata.namespace,
    },
    spec: {
      containers: [
        {
          name: 'app',
          image: cm.data.image,
        },
      ],
    },
  },

  apply: [] + (if std.objectHas(cm.metadata, 'labels') && std.objectHas(cm.metadata.labels, 'convert-to-pod') then [pod] else []),
}
