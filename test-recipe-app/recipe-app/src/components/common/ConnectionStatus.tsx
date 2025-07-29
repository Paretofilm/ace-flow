import { ConnectionState } from 'aws-amplify/data';
import { useConnectionState } from '../../hooks/useConnection';

export default function ConnectionStatus() {
  const { connectionState } = useConnectionState();

  if (connectionState === ConnectionState.Connected) {
    return null;
  }

  return (
    <div className="connection-status offline">
      <span className="status-icon">⚠️</span>
      <span className="status-text">
        {connectionState === ConnectionState.Disconnected
          ? 'Offline - Changes will sync when reconnected'
          : 'Connecting...'}
      </span>
    </div>
  );
}