export interface Env {
  production: boolean;
  env: 'dev' | 'prod';

  moralis: {
    /** Moralis Application ID */
    appId: string;
    /** Moralis Server URL */
    serverUrl: string;
  };
}

export const defaultEnv: Env = {
  production: true,
  env: 'prod',
  moralis: {
    appId: 'https://lhwouakelxhg.usemoralis.com:2053/server',
    serverUrl: 'Rfw5GSpPGOfmENUdFssOV21JDfQDyhZ3Z7X9thWK'
  }
};
