class ResourceFinder {
  String? name;
  String? ip;
  String? type;
  ResourceFinder({this.name, this.ip, this.type});
}

List<ResourceFinder> mylist = [
  ResourceFinder(name: "Sanity Node", ip:"10.74.12.53", type: "Selenoid"),
  ResourceFinder(name: "Regression Node", ip:"10.74.132.5", type: "Selenoid"),
  ResourceFinder(name: "Fraud Node", ip:"10.174.112.5", type: "GGR"),
  ResourceFinder(name: "ud Node", ip:"10.1.112.5", type: "Jenkins"),
  ResourceFinder(name: "Mobile Node 1", ip:"10.74.12.66", type: "Selenoid"),
  ResourceFinder(name: "Performance Node 1", ip:"10.74.132.10", type: "Selenoid"),
  ResourceFinder(name: "Payment Node 1", ip:"10.174.112.25", type: "GGR"),
  ResourceFinder(name: "Staging Node 1", ip:"10.1.112.8", type: "Jenkins"),
  ResourceFinder(name: "Mobile Node 2", ip:"10.74.12.75", type: "Selenoid"),
  ResourceFinder(name: "Performance Node 2", ip:"10.74.132.13", type: "Selenoid"),
  ResourceFinder(name: "Payment Node 2", ip:"10.174.112.33", type: "GGR"),
  ResourceFinder(name: "Staging Node 2", ip:"10.1.112.11", type: "Jenkins"),
  ResourceFinder(name: "Mobile Node 3", ip:"10.74.12.80", type: "Selenoid"),
  ResourceFinder(name: "Performance Node 3", ip:"10.74.132.18", type: "Selenoid"),
  ResourceFinder(name: "Payment Node 3", ip:"10.174.112.37", type: "GGR"),
  ResourceFinder(name: "Staging Node 3", ip:"10.1.112.15", type: "Jenkins"),
  ResourceFinder(name: "Mobile Node 4", ip:"10.74.12.91", type: "Selenoid"),
  ResourceFinder(name: "Performance Node 4", ip:"10.74.132.22", type: "Selenoid"),
  ResourceFinder(name: "Payment Node 4", ip:"10.174.112.42", type: "GGR"),
  ResourceFinder(name: "Staging Node 4", ip:"10.1.112.19", type: "Jenkins"),
  ResourceFinder(name: "Test Node", ip:"10.1.112.20", type: "GGR"),
];

