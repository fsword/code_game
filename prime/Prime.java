import java.lang.Math;
class Prime{
    public static void main(String[] args) {
        long start = System.currentTimeMillis();
        // 统计范围
        int N = Integer.parseInt(args[0]);//100000000;
        boolean[] primes = new boolean[N];
        // 0和1不是素数
        primes[0] = true;
        primes[1] = true;
        int loop = new Double(Math.sqrt((double)N)).intValue(); // 2;
        for (int i = 2; i < loop; i++) {
            if (primes[i]) {
                continue;
            }
            for (int j = 2;; j++) {
                int k = i * j;
                if (k > N - 1) {
                    break;
                } else {
                    primes[k] = 
                        true;
                }
            }
        }
        int count = 0;
        for (int i = 0; i < N; i++) {
            if (!primes[i]) {
                count++;
            }
        }
        long end = System.currentTimeMillis();
        System.out.println(count);
        System.out.println((end - start) + "ms");
    }
}
