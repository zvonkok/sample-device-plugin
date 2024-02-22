# Copyright 2018 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


bin:
	go build . 
	docker build . -t ghcr.io/zvonkok/sample-device-plugin
	docker push ghcr.io/zvonkok/sample-device-plugin

run: 
	kubectl delete -f sample-device-plugin.yaml
	kubectl apply -f sample-device-plugin.yaml
	sleep 5
	kubectl logs -f $(kubectl get pods --no-headers=true -o name | awk -F "/" '{print $2}'| grep sample)
.PHONY: bin
