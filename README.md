```
# 🚀 Petclinic Application & CI Pipeline

![Build Status](https://img.shields.io/badge/Build-Passing-brightgreen) ![Java](https://img.shields.io/badge/Java-17-orange) ![Spring Boot](https://img.shields.io/badge/SpringBoot-3.0-green) ![Docker](https://img.shields.io/badge/Docker-Multi--Cloud-blue)

안녕하세요! 이 저장소는 **MSA 기반 Petclinic 애플리케이션의 소스 코드**와 **Multi-Cloud CI 전략**을 담고 있습니다.
단순한 빌드를 넘어, **운영 효율성**과 **재해 복구(DR)**를 고려하여 배포 시나리오를 이원화했습니다.

---

## 📂 Project Structure

Spring Boot 애플리케이션 구조와 CI/CD 워크플로우 설정 파일이 포함되어 있습니다.

```text
.
├── .github/                
│   └── workflows/          
│       └── ci-pipeline.yaml   # ⚙️ 핵심: CI 파이프라인 (ECR / GAR 분기 처리)
├── src/                    
│   ├── main/
│   │   ├── java/              # Backend Source Code
│   │   └── resources/         # Application Configs
│   └── test/                  # Unit Tests
├── Dockerfile                 # Multi-stage Docker Build
├── pom.xml                    # Maven Dependency Management
└── README.md                  # Project Documentation
```

---

🏗️ CI Architecture (Multi-Cloud Registry Strategy)
비용 효율성과 안정성을 모두 잡기 위해 Git Event에 따라 파이프라인 동작을 다르게 설계했습니다.

1. 🟢 Routine Dev (일반 개발)
Trigger: git push (Feature/Main branch)

Action: 개발 단계에서는 빠른 빌드와 테스트가 목적입니다.

Target: AWS ECR에만 이미지를 업로드합니다.

2. 🔴 Release & DR (운영 배포)
Trigger: git tag push (e.g., v1.0.0)

Action: 실제 운영 배포 및 재해 복구(DR) 대비용 이미지를 생성합니다.

Target: AWS ECR + GCP GAR (Google Artifact Registry) 두 곳에 동시에 업로드합니다.

Next Step: 업로드 완료 후, Ops Repo의 매니페스트를 자동으로 수정하여 ArgoCD 배포를 트리거합니다.

---

🚀 How to Use
시나리오 A: 기능 개발 및 테스트
코드를 수정하고 단순히 푸시하면 AWS ECR에 이미지가 빌드됩니다.

```
git add .
git commit -m "Feat: 회원가입 로직 개선"
git push origin main
```

시나리오 B: 정식 버전 릴리즈 (Multi-Cloud Push)
검증된 코드를 운영 환경에 배포할 때는 태그를 붙여주세요. GCP까지 이미지가 복제됩니다.
```
# v로 시작하는 태그 생성
git tag v1.0.2

# 태그 푸시 -> CI가 ECR & GAR 업로드 및 Ops Repo 수정 수행
git push origin v1.0.2
```

--- 

🔑 CI Environment Secrets
GitHub Actions가 클라우드 리소스에 접근하기 위해 아래의 Secret 키들이 설정되어야 합니다.

```Key Name,Description
AWS_ACCESS_KEY_ID,AWS ECR | 접근 권한
AWS_SECRET_ACCESS_KEY,AWS | 시크릿 키
GCP_CREDENTIALS_JSON,GCP GAR | 접근을 위한 Service Account Key (Base64 Encoded)
ACTION_TOKEN,Ops Repo(GitOps) | 수정을 위한 Personal Access Token
```

---

🧑‍💻 Engineer's Note (Retrospective)
"왜 레지스트리를 두 곳이나 쓸까요?"

처음에는 AWS ECR만 사용했지만, **"만약 AWS 서울 리전에 장애가 발생한다면?"**이라는 질문에서 이 아키텍처를 고안했습니다.

평소 개발 시에는 속도를 위해 ECR만 사용하지만, 중요한 Release 버전은 GCP GAR에도 백업하여 Multi-Cloud DR(Disaster Recovery) 환경을 구축했습니다. 이를 통해 특정 클라우드 벤더의 장애 상황에서도 유연하게 대처할 수 있는 탄력적인 인프라를 지향합니다.

---
Created by [ 홍 정 호 ], KDT DevOps Engineering Student.