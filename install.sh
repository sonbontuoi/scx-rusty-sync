#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'

if [ ! -d "config" ]; then
  echo "Lỗi: Không tìm thấy thư mục config. Hãy chạy script từ thư mục gốc của dự án."
  exit 1
fi

echo -e "${GREEN}--- Bắt đầu cài đặt scx-rusty-sync ---${NC}"

if [ "$EUID" -ne 0 ]; then 
  echo "Vui lòng chạy script bằng sudo: sudo ./install.sh"
  exit
fi

echo "Đang cấu hình thư mục /opt/scx-rusty-sync..."
mkdir -p /opt/scx-rusty-sync
cp scx-rusty-sync.sh /opt/scx-rusty-sync/
chmod +x /opt/scx-rusty-sync/scx-rusty-sync.sh

echo "Đang cài đặt Systemd Service..."
cp config/services/run_scx_rusty.service /etc/systemd/system/
cp config/services/scx_rusty_sync.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable scx_rusty_sync.service

echo "Đang cài đặt Udev Rule..."
cp config/rules/99-scx-rusty-sync.rules /etc/udev/rules.d/
udevadm control --reload

echo "Đang kiểm tra trạng thái nguồn điện hiện tại..."
/opt/scx-rusty-sync/scx-rusty-sync.sh

echo -e "${GREEN}--- Cài đặt HOÀN TẤT! ---${NC}"
echo "Máy của bạn đã sẵn sàng tự động hóa bộ lập lịch Rusty."