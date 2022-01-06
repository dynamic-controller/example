function(request) {
  local ns = request.object,

  local pod = {
    apiVersion: 'v1',
    kind: 'Pod',
    metadata: {
      name: 'some-pod',
      namespace: ns.metadata.name,
    },
    spec: {
      containers: [
        {
          name: 'app',
          image: 'ubuntu',
          command: ['sleep', '100000'],
        },
      ],
    },
  },

  apply: [] + (if std.objectHas(ns.metadata, 'labels') && std.objectHas(ns.metadata.labels, 'run-pod') then [pod] else []),
}
