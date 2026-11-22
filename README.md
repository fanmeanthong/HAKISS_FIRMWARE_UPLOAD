# HAKISS – MicroPython Firmware Flash Web App (ESP32-S3 N16R8)

Bản sửa từ `index(2).html` do người dùng cung cấp, rút gọn xuống **một firmware MicroPython duy nhất**.

## Firmware cố định

- Chip mục tiêu: **ESP32-S3 DevKitC-1 N16R8** (16 MB Flash / 8 MB PSRAM Octal).
- MicroPython chính thức **v1.29.0** / **ESP32_GENERIC_S3-SPIRAM_OCT**.
- Tên file khi host: `firmware.bin`.
- Địa chỉ nạp: **`0x0`**.
- Nguồn: https://micropython.org/resources/firmware/ESP32_GENERIC_S3-SPIRAM_OCT-20260824-v1.29.0.bin
- Trang chính thức: https://micropython.org/download/ESP32_GENERIC_S3/

## Chuẩn bị 1 lần dành cho người quản trị

**Lưu ý:** Do môi trường tạo gói không thể tải được firmware nhị phân, ZIP này **chưa chứa `firmware.bin`**. Không nhấn nạp nếu chưa bổ sung tệp chính thức.

Trên Windows, chạy `tai_firmware.bat` khi có Internet. Script tải firmware từ MicroPython.org về `firmware.bin` trong cùng thư mục. Hoặc tự tải file `.bin` từ trang MicroPython, sau đó đổi tên thành `firmware.bin`.

Kiểm tra cấu trúc:

```
HAKISS_MicroPython_WebFlasher/
  index.html
  manifest.json
  firmware.bin          <-- cần tải thêm một lần
  app.webmanifest
  icon.svg
  tai_firmware.bat      <-- không cần upload lên website
  README.md             <-- không cần upload lên website
```

Upload `index.html`, `manifest.json`, `firmware.bin`, `app.webmanifest`, `icon.svg` lên cùng một thư mục của hosting HTTPS, ví dụ `https://flash.hakiss.vn/`. Dùng Cloudflare Pages, GitHub Pages hoặc web hosting tĩnh có HTTPS đều được. **Không mở file `index.html` bằng `file://`.**

Nếu đổi bản firmware khác, cập nhật cả `firmware.bin`, trường `version` của `manifest.json` và nhãn phiên bản trong `index.html`, sau đó kiểm tra tương thích chip.

## Cách dùng cho giáo viên

1. Dùng **Chrome hoặc Edge trên máy tính**, truy cập website HTTPS.
2. Cắm ESP32-S3 qua USB và đóng các Serial Monitor đang chiếm cổng COM.
3. Đánh dấu xác nhận xóa dữ liệu.
4. Nhấn **XÓA FLASH & NẠP MICROPYTHON**, chọn cổng COM.
5. Làm theo hộp thoại ESP Web Tools để nạp; chờ hoàn thành, nhấn RST/EN nếu cần.

Nếu không kết nối được, giữ BOOT → bấm/thả RST → thả BOOT, thử lại. USB-C qua UART hoặc USB native có thể xuất hiện dưới tên COM khác nhau.

## Bảo mật, phạm vi và kiểm thử

- Dùng ESP Web Tools v10 qua CDN. Khi chạy lần đầu trình duyệt phải có Internet để tải thư viện.
- Manifest chỉ khai báo một image ESP32-S3 tại offset 0. `new_install_prompt_erase: false` để một lượt cài mới mặc định xóa Flash theo thiết kế ESP Web Tools. Việc **xóa sạch Flash** cần được người dùng xác nhận; không có nút xóa độc lập ở bản đơn giản này.
- ESP Web Tools yêu cầu **HTTPS hoặc localhost**, Web Serial và thao tác cho phép cổng từ người dùng. Google Apps Script iframe có thể chặn Web Serial; dùng hosting HTML độc lập thay vì nhúng trong Apps Script.
- Chương trình chỉ kiểm tra việc có firmware tại địa chỉ host và tính hợp lệ cơ bản; **chưa xác minh chữ ký/hash firmware**, nên người quản trị phải tự đảm bảo file tải chính thức và đúng model.
- Chưa kiểm thử trên phần cứng thật. Không dùng để nạp board khác ESP32-S3 N16R8.
- Nạp MicroPython sẽ không tự cài lại `main.py`, `supervisor.py`, `user_app.py` hay các thư viện HAKISS WebCode; cần nạp lại các file này riêng nếu muốn dùng WebCode.
