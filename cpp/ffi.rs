use std::ffi::c_void;

unsafe extern "C" {
    fn verilator_new() -> *mut c_void;
    fn free(sim: *mut c_void);
    fn eval(sim: *mut c_void);
}

pub struct Sim {
    ptr: *mut c_void,
}

impl Sim {
    pub fn new() -> Self {
        unsafe {
            let ptr = verilator_new();
            Self { ptr }
        }
    }
    pub fn eval(&mut self) {
        unsafe {
            eval(self.ptr);
        }
    }
}

impl Drop for Sim {
    fn drop(&mut self) {
        unsafe {
            free(self.ptr);
        }
    }
}
