local env = std.extVar("__ksonnet/environments");
local params = std.extVar("__ksonnet/params").components["docker-counter-deployment"];
local k = import "k.libsonnet";
local deployment = k.apps.v1beta1.deployment;
local container = k.apps.v1beta1.deployment.mixin.spec.template.spec.containersType;
local port = container.portsType;

deployment.new(
  params.name,
  params.replicas,
  container
    .new(params.name, params.image)
    .withPorts(port.new(params.port)),
  {app: params.name})