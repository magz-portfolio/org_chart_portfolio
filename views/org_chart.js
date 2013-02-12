
console.log("here");
function OrgChart(name, rootNode) {
	this.name = name;
	this.rootNode = rootNode;

}
Orgchart.get_orgchart_index = function() {
	return $.ajax({url:"org_charts/index",
		success:function(result){
			return result
		}
	});
}

OrgChart.build_from_json = function(json) {

}
function Node(employeeName, employeeJob, database_id, parentNode=null) {
	this.employeeName = employeeName;
	this.employeeJob = employeeJob;
	this.children = []; 
	this.parentNode = parentNode;
	this.database_id = null;
	if(Node.allNodes == undefined)
		Node.allNodes = []
	else
		Node.allNodes.push(this)
	// this.getOwnChildren = function(){
	// 	return this.children;
	// }
	//returns all children of the node in a flattened array
	this.getAllChildren = function(){
		var allChildren = [];
		var queue = this.children.map(function(x){return x});
		while(queue.length != 0){
			var child = queue.pop();
			allChildren.push(child);
			child.children.map(function(x){queue.push(x)});
		}
		return allChildren;
	}
	this.addChild = function(childNode) {
		//this should really have error checking to ensure that the new node remains a tree [i.e. there are no circuits]
		//but i'm not going to do that here
		this.children.push(childNode);
		return childNode;
	}
	this.removeChild = function(childNode) {
		this.children = this.children.filter(function(x){ return x !== childNode});
		childNode.parentNode = null;
		return this.children;
	}
	//returns the subtree with this node as the root as a nested hash
	// this.tree = function() {
	// 	return {"node":this, 
	// 			"attributes": {
	// 				"employeeName": this.employeeName,
	// 				"employeeJob": this.employeeJob
	// 			},
	// 			"children": this.getOwnChildren().map(function(x) {
	// 				return x.tree();
	// 				}
	// 				)
	// 		}
	// }
	this.displayTree = function() {
		return JSON.stringify(this);
	}
	
	this.orderedTree = function(order_method) {

		return this.getAllChildren().sort(function(a,b){
			//in ruby i would use the <=> operator for this, but jS doesn't have one to my knowledge, making this a bit clumsier
			//i like this method for sorting because it will automatically extend for any additional attributes (e.g. salary)
			if(a[order_method] > b[order_method])
				return 1
			else if(a[order_method] < b[order_method])
				return -1
			else
				return 0
		})


	}


}
//class method since i think that's where transactions like this belong
//this should have error checking to ensure that this is actually transactional [i.e. all or nothing], but i'm going to leave that off for now
Node.moveNode = function(targetNode, newParent) {	
	targetNode.parentNode.removeChild(targetNode);
	targetNode.parentNode = newParent;
	newParent.addChild(targetNode);

}
//unusued utility method
Node.where_attribute= function(attribute, parameter) {
	if(Node.allNodes == undefined)
		return null
	else
		return Node.allNodes.filter(function(x){return x[attribute] == parameter})
}
//used for assembling nodes from json received from the server
//database id should be unique, so we can just pull the first that fits
Node.find_by_attribute= function(attribute, parameter) {
	if(Node.allNodes == undefined)
		return null
	else
		return Node.allNodes.filter(function(x){return x[attribute] == parameter})[0]
}

var magz = new Node("magz", "developer", 1);
var cav = magz.addChild(new Node("cav", "banker", 2, magz));
var noelle = cav.addChild(new Node("noelle", "asst", 3, cav));

