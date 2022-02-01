# JOINT EGO-NOISE SUPPRESSION AND KEYWORD SPOTTING ON SWEEPING ROBOTS

Yueyue Na<sup>1</sup>, Ziteng Wang<sup>1</sup>, Liang Wang<sup>2</sup>, Qiang Fu<sup>1</sup>

<sup>1</sup>Alibaba Group, China </br>
{yueyue.nyy, ziteng.wzt, fq153277}@alibaba-inc.com

<sup>2</sup>School of Electronics and Communication Engineering </br>
Sun Yat-sen University (SYSU), Guangzhou, Guangdong, 510275, China </br>
wangliang7@mail.sysu.edu.cn

# ABSTRACT
Keyword spotting is necessary for triggering human-machine speech interaction. It is a challenging task especially in low signal-to-noise ratio and moving scenarios, such as on a sweeping robot with strong ego-noise. This paper proposes a novel approach for joint ego-noise suppression and keyword detection. The keyword detection model accepts outputs from multi-look adaptive beamformers. The noise covariance matrix in the beamformer is in turn updated using the keyword absence probability given by the model, forming an end-to-end loop-back. The keyword model also adopts a multi-channel feature fusion using self-attention, and a hidden Markov model for online decoding. The performance of the proposed approach is verified on real-word datasets recorded on a sweeping robot.

# Generate Differential Beamformers
The differential beamformers used in this paper is generated by solving the following complex optimization problem by CVX [1].

$$
\begin{aligned}
    \mathbf{w} = &\min \mathbf{w}^H \mathbf{\Phi} \mathbf{w} \\
    s.t. \quad &\mathbf{w}^H \mathbf{a} = 1 \\
               &\mathbf{w}^H \mathbf{w} \le 10^{g_{min} / 10}
\end{aligned}
$$


# References
- [1] [cvx] (http://cvxr.com/cvx/)
