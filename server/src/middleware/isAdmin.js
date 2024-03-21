// isAdmin.js
const isAdmin = (user) => {
    // Thực hiện kiểm tra xem người dùng có phải là admin không
    // Ở đây, bạn có thể xác định cách nhận biết một người dùng là admin dựa trên cơ sở dữ liệu hoặc các điều kiện khác.
    // Ví dụ: nếu trong cơ sở dữ liệu, có một cột 'role' và giá trị của người dùng là 'admin', thì trả về true.
    // Đây chỉ là một ví dụ, bạn cần điều chỉnh hàm này để phản ánh logic xác định người dùng là admin của hệ thống của bạn.
    return user.role === 'admin';
};

module.exports = {isAdmin};
