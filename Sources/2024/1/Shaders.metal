#include <metal_stdlib>
using namespace metal;

kernel void inOutExample(device uint *inBuf[[buffer(0)]],
                         device uint *outBuf[[buffer(1)]],
                         uint threadPositionInGrid [[thread_position_in_grid]],
                         uint threadPositionInThreadgroup [[thread_position_in_threadgroup]],
                         uint threadsPerThreadgroup [[threads_per_threadgroup]],
                         uint threadgroupPositionInGrid [[threadgroup_position_in_grid]]){
  int index = threadgroupPositionInGrid * threadsPerThreadgroup + threadPositionInThreadgroup;
  outBuf[index] = inBuf[index];
}
