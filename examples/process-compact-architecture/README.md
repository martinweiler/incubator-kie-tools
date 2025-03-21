<!--
   Licensed to the Apache Software Foundation (ASF) under one
   or more contributor license agreements.  See the NOTICE file
   distributed with this work for additional information
   regarding copyright ownership.  The ASF licenses this file
   to you under the Apache License, Version 2.0 (the
   "License"); you may not use this file except in compliance
   with the License.  You may obtain a copy of the License at
     http://www.apache.org/licenses/LICENSE-2.0
   Unless required by applicable law or agreed to in writing,
   software distributed under the License is distributed on an
   "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
   KIND, either express or implied.  See the License for the
   specific language governing permissions and limitations
   under the License.
-->

# Process Compact Architecture Quarkus Example

Reproducer for https://jsw.ibm.com/browse/DBACLD-171369

1. Compile the project

```
mvn clean package -Pcontainer
```

2. Run the project with docker compose (example profile)

```
docker compose up
```

3. Run the load test against the 'hiring' process (original process definition)

```
sh load-test-compact-arch-example.sh
```

Using the original process definition, all process instances get finished:

```
-------------------------------------------------------
RESULT: 0 of 100 process instances open
-------------------------------------------------------
```

4. Run the load test against the 'hiring_join' process (new process definition)

```
sh load-test-compact-arch-example.sh hiring_join
```

Using the updated process definition, NOT all process instances get finished:

```
-------------------------------------------------------
RESULT: 23 of 100 process instances open
-------------------------------------------------------
```

The number of unfinished processes varies on each run, with the instances stuck in the join node.
