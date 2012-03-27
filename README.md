Jinx JSON plug-in
=================

**Home**:         [http://github.com/jinx/json](http://github.com/jinx/json)    
**Git**:          [http://github.com/jinx/json](http://github.com/jinx/json)       
**Author**:       OHSU Knight Cancer Institute    
**Copyright**:    2012    
**License**:      MIT License    

Synopsis
--------
Jinx JSON enables JSON serialization for [Jinx]((http://github.com/jinx/core) resources.

Installing
----------
Jinx JSON is installed as a JRuby gem:

    [sudo] jgem install jinx-json

Usage
-----
Enable Jinx for a Java package, as described in the [Jinx]((http://github.com/jinx/json/core) Usage.

    require 'jinx/json'
    jsoned = jinxed.to_json #=> the JSON representation of a jinxed resource
    JSON[jsoned] #=> the deserialized jinxed resource

Copyright
---------
Jinx &copy; 2011 by [Oregon Health & Science University](http://www.ohsu.edu/xd/health/services/cancer/index.cfm).
Jinx is licensed under the MIT license. Please see the LICENSE and LEGAL files for more information.
