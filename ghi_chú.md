

# đã hoàn thành
# Cài và chạy LocalStack bằng Docker
# Viết Terraform để tự động tạo tài nguyên (S3, VPC, EC2).
# Kết nối thành công Terraform → LocalStack (AWS local).
# “Apply” hạ tầng ảo thành công mà không cần truy cập AWS thật
# them vao github 


🧭 Phần 1: Thêm dự án vào GitHub
✅ Bước 1. Kiểm tra repo local

Giả sử bạn đang ở thư mục dự án:

localstack-terra-demo/


Chạy:

git status


→ đảm bảo bạn đang trong repo Git và không còn file .terraform/ nặng.

✅ Bước 2. Kết nối đến GitHub

Nếu repo trên GitHub đã có sẵn:

git remote add origin git@github.com:mrvan-design/localstack-terra-demo.git


(hoặc dùng HTTPS)

git remote add origin https://github.com/mrvan-design/localstack-terra-demo.git

✅ Bước 3. Commit & Push code
git add .
git commit -m "Add Terraform + LocalStack project"
git push origin main


💡 Nếu bị lỗi “fetch first”, thì chạy:

git pull origin main --rebase
git push origin main

⚙️ Phần 2: Tự động hoá bằng GitHub Actions

GitHub Actions cho phép bạn tự động chạy Terraform hoặc kiểm tra code mỗi khi push code lên GitHub.

✅ Bước 1. Tạo cấu trúc workflow

Tạo thư mục:

.github/workflows/


Trong đó, tạo file:

terraform.yml

✅ Bước 2. Nội dung file terraform.yml

Dán nội dung sau:

name: Terraform CI

on:
  push:
    branches:
      - main
  pull_request:

jobs:
  terraform:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3

      - name: Terraform Init
        run: terraform init

      - name: Terraform Validate
        run: terraform validate

      - name: Terraform Plan
        run: terraform plan


💡 File này sẽ:

Tự động checkout code

Cài Terraform

Kiểm tra cấu hình (terraform validate)

Lập kế hoạch triển khai (terraform plan)
Mọi bước chạy tự động mỗi khi bạn push code lên GitHub.

✅ Bước 3. Commit và push file workflow
git add .github/workflows/terraform.yml
git commit -m "Add Terraform GitHub Actions workflow"
git push origin main


Sau khi push, vào tab “Actions” trên GitHub → bạn sẽ thấy workflow đang chạy 🎯

🧠 Tổng tóm tắt (dễ nhớ):
Mục tiêu	Lệnh/Thao tác chính
Kết nối repo GitHub	git remote add origin <URL>
Push code	git push origin main
Tạo GitHub Actions	.github/workflows/terraform.yml
Workflow cơ bản	init → validate → plan
Kiểm tra kết