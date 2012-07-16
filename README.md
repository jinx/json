Jinx JSON plug-in
=================
**Home**:         [http://github.com/jinx/json](http://github.com/jinx/json)    
**Git**:          [http://github.com/jinx/json](http://github.com/jinx/json)       
**Author**:       OHSU Knight Cancer Institute    
**Copyright**:    2012    
**License**:      MIT License    

Synopsis
--------
Jinx JSON enables JSON serialization for [Jinx](http://github.com/jinx/core) resources.

Installing
----------
Jinx JSON is installed as a JRuby gem:

    [sudo] jgem install jinx-json

Usage
-----
Enable Jinx for a Java package, as described in the [Jinx](http://github.com/jinx/json/core) Usage.

    require 'jinx/json'
    jsoned = jinxed.to_json #=> the JSON representation of a jinxed resource
    JSON[jsoned] #=> the deserialized jinxed resource
    JSON

The JSON payload consists of the following:

* The standard primitive Java properties, e.g. [caTissue](http://github.com/caruby/tissue)
  <tt>SpecimenCollectionGroup.surgicalPathologyNumber</tt>. If there is a Java <tt>id</tt> property,
  then designate that property with <tt>identifier</tt>, since <tt>id</tt> is a reserved Ruby
  method.

* An object identifier property <tt>object_id</tt> which uniquely identifies the object in the scope
  of the JSON object graph.

* The standard Jinx <tt>Resource<tt/> reference properties, e.g. caTissue
  <tt>TissueSpecimen.specimenCollectionGroup</tt>. If the referenced object content contains the
   <tt>object_id</tt> property, then the reference resolves to the object defined in the JSON
   object graph with that <tt>object_id</tt> value.

Copyright
---------
Jinx &copy; 2012 by [Oregon Health & Science University](http://www.ohsu.edu/xd/health/services/cancer).
Jinx is licensed under the MIT license. Please see the LICENSE and LEGAL files for more information.
