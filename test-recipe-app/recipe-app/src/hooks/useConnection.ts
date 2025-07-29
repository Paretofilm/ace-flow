import { useState, useEffect } from 'react';
import { CONNECTION_STATE_CHANGE, ConnectionState } from 'aws-amplify/data';
import { Hub } from 'aws-amplify/utils';

export function useConnectionState() {
  const [connectionState, setConnectionState] = useState<ConnectionState>(
    ConnectionState.Connected
  );
  const [pendingChanges, setPendingChanges] = useState<number>(0);
  
  useEffect(() => {
    const hubListener = Hub.listen('api', (data: any) => {
      const { payload } = data;
      if (payload.event === CONNECTION_STATE_CHANGE) {
        const state = payload.data.connectionState as ConnectionState;
        setConnectionState(state);
        
        // Track pending changes
        if (state === ConnectionState.Disconnected) {
          console.log('Lost connection - changes will be queued');
        } else if (state === ConnectionState.Connected) {
          console.log('Connection restored - syncing changes');
        }
      }
    });
    
    return () => hubListener();
  }, []);
  
  return { connectionState, pendingChanges };
}