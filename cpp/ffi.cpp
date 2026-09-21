#include "verilated.h"
#include "Vtop.h"
#include <cstdint>
#include <memory>

class Sim
{
  public:
    // NO SMART POINTERS!!!
    VerilatedContext ctxt;
    Vtop v_top;
    Sim()
    {
      this->ctxt = new VerilatedContext;
      this->v_top = new ctxt(this->ctxt);
    }
    ~Sim()
    {
      top->final();
      delete cxt;
      delete v_top;
    }
};

extern "C"
{
  auto verlator_new() -> void* {
    return new Sim();  
  }
  auto free(void* pointer) -> void{
    delete (Sim*) pointer;
  }
  
  auto eval(void* pointer) -> void {
    auto*  sim = (Sim*) pointer;
    sim->v_top->eval();
  }
  
}
