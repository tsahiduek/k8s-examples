kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: jenkins-cr
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["create","delete","get","list","patch","update","watch"]
- apiGroups: [""]
  resources: ["pods/exec"]
  verbs: ["create","delete","get","list","patch","update","watch"]
- apiGroups: [""]
  resources: ["pods/log"]
  verbs: ["get","list","watch"]
- apiGroups: [""]
  resources: ["secrets"]
  verbs: ["get"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: jenkins-crb
subjects:
  - kind: ServiceAccount
    name: jenkins-sa
    namespace: default
roleRef:
  kind: ClusterRole
  name: jenkins-cr
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: jenkins-sa
EOF

JENKINS_SECRET_NAME=$(kubectl get sa jenkins-sa -o=jsonpath='{.secrets[0].name}')
kubectl get secret $JENKINS_SECRET_NAME  -o go-template='{{index .data "ca.crt"}}' | base64 --decode > jenkins-eks.crt
kubectl get secret $JENKINS_SECRET_NAME  -o go-template='{{index .data "token"}}' | base64 --decode > jenkins-eks.token
